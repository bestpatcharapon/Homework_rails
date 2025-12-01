# Deployment Guide - Render with Docker

คู่มือการ deploy Rails application บน Render โดยใช้ Docker และ Blueprint

## Prerequisites

1. **Git Repository**: โค้ดต้องอยู่บน Git repository (GitHub, GitLab, Bitbucket, etc.)
2. **Render Account**: สมัครบัญชีที่ [https://render.com](https://render.com)
3. **RAILS_MASTER_KEY**: ดูค่าจากไฟล์ `config/master.key` ในโปรเจคของคุณ

## ขั้นตอนการ Deploy

### 1. Push โค้ดไปยัง Git Repository

```bash
cd /home/gagabox5678/project_rails/store
git add .
git commit -m "Setup Render deployment with Docker"
git push origin main
```

> [!NOTE]
> เปลี่ยน `main` เป็นชื่อ branch ที่คุณใช้งาน (อาจจะเป็น `master` หรืออื่นๆ)

### 2. เชื่อม Repository กับ Render

1. ไปที่ [Render Dashboard](https://dashboard.render.com)
2. คลิก **"Blueprints"** ในเมนูด้านซ้าย
3. คลิก **"New Blueprint Instance"**
4. เลือก Git provider ของคุณ (GitHub, GitLab, etc.)
5. Authorize Render ให้เข้าถึง repository
6. เลือก repository `project_rails/store`
7. เลือก branch ที่ต้องการ deploy

### 3. ตั้งค่า Environment Variables

Render จะอ่านไฟล์ `render.yaml` และแสดงรายการ services ที่จะสร้าง คุณต้องตั้งค่า `RAILS_MASTER_KEY`:

1. หาค่า RAILS_MASTER_KEY:

   ```bash
   cat /home/gagabox5678/project_rails/store/config/master.key
   ```

2. ใน Render Dashboard:
   - คลิกที่ service **"store"**
   - ไปที่ **Environment** tab
   - หา `RAILS_MASTER_KEY` ในรายการ
   - ใส่ค่าที่ได้จากขั้นตอนที่ 1
   - คลิก **"Save Changes"**

### 4. Deploy

1. คลิก **"Apply"** เพื่อสร้าง services และ database
2. Render จะเริ่ม build Docker image และ deploy
3. รอให้ build เสร็จ (อาจใช้เวลา 5-10 นาที)
4. เมื่อเสร็จแล้วจะได้ URL สำหรับเข้าใช้งาน เช่น `https://store-xyz.onrender.com`

## Services ที่จะถูกสร้าง

ตามที่กำหนดใน `render.yaml`:

### Database

- **Name**: `store_db`
- **Type**: PostgreSQL
- **Database Name**: `store_production`
- **User**: `store`

### Web Service

- **Name**: `store`
- **Type**: Web Service
- **Runtime**: Docker
- **Region**: Singapore
- **Plan**: Free

## Environment Variables

| Variable           | Description                  | Source                            |
| ------------------ | ---------------------------- | --------------------------------- |
| `DATABASE_URL`     | PostgreSQL connection string | Auto from database                |
| `RAILS_MASTER_KEY` | Rails credentials key        | Manual (from `config/master.key`) |
| `RAILS_ENV`        | Rails environment            | Set to `production`               |
| `PORT`             | Web server port              | Set to `10000`                    |

## การอัพเดทโค้ด

เมื่อต้องการอัพเดทโค้ดใหม่:

```bash
git add .
git commit -m "Your update message"
git push origin main
```

Render จะ auto-deploy เมื่อมี commits ใหม่เข้ามาใน branch ที่เลือกไว้

## Troubleshooting

### Build Failed

**อาการ**: Build ล้มเหลวด้วย error เกี่ยวกับ dependencies

**แก้ไข**:

1. ตรวจสอบ logs ใน Render Dashboard
2. ตรวจสอบว่า `Gemfile` และ `package.json` ถูกต้อง
3. ตรวจสอบว่า Ruby version ใน `.ruby-version` ตรงกับที่กำหนดใน Dockerfile

### Database Connection Error

**อาการ**: Application รันได้แต่เชื่อมต่อ database ไม่ได้

**แก้ไข**:

1. ตรวจสอบว่า `DATABASE_URL` ถูกตั้งค่าอัตโนมัติจาก database service
2. รอให้ database service พร้อมใช้งาน (status: Available)
3. Restart web service

### RAILS_MASTER_KEY Error

**อาการ**: Error เกี่ยวกับ `ActiveSupport::EncryptedFile::MissingKeyError`

**แก้ไข**:

1. ตรวจสอบว่าได้ตั้งค่า `RAILS_MASTER_KEY` แล้ว
2. ตรวจสอบว่าค่าที่ใส่ถูกต้อง (copy จาก `config/master.key`)
3. Restart web service หลังตั้งค่า

### Port Binding Error

**อาการ**: Application ไม่สามารถ bind port ได้

**แก้ไข**:

1. ตรวจสอบว่า Dockerfile expose port 10000
2. ตรวจสอบว่า `PORT` environment variable ถูกตั้งเป็น "10000"
3. ตรวจสอบว่า Rails server รับ argument `-p 10000` และ `-b 0.0.0.0`

### Application Crashes on Startup

**อาการ**: Service restart วนลูป

**แก้ไข**:

1. ดู logs ใน Render Dashboard
2. ตรวจสอบว่า database migrations รันสำเร็จ
3. ตรวจสอบว่า docker-entrypoint script มี execute permissions

## เพิ่มเติม

### การดู Logs

1. ไปที่ Render Dashboard
2. เลือก service ที่ต้องการ
3. คลิก **"Logs"** tab

### การ Run Rails Console

ใช้ Render Shell:

1. ไปที่ service page
2. คลิก **"Shell"** tab
3. รัน: `./bin/rails console`

### การ Run Database Migrations

Migrations จะรันอัตโนมัติผ่าน `docker-entrypoint` script แต่ถ้าต้องการรันเอง:

1. เปิด Shell
2. รัน: `./bin/rails db:migrate`

## ข้อมูลเพิ่มเติม

- [Render Documentation](https://render.com/docs)
- [Render Docker Deployment](https://render.com/docs/docker)
- [Render Blueprints](https://render.com/docs/infrastructure-as-code)
