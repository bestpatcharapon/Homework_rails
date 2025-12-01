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

> [!IMPORTANT] > **เนื่องจาก Render free tier อนุญาตให้มี PostgreSQL database ได้แค่ 1 ตัว** เราจะไม่สร้าง database ใหม่ แต่จะใช้ database ที่มีอยู่แล้วในบัญชีของคุณ

Render จะอ่านไฟล์ `render.yaml` และแสดงรายการ services ที่จะสร้าง คุณต้องตั้งค่า Environment Variables ดังนี้:

#### 3.1 หาค่า RAILS_MASTER_KEY:

```bash
cat /home/gagabox5678/project_rails/store/config/master.key
```

ค่าคือ: `97c5e88078a4a09049ab2df74abbc164`

#### 3.2 หาค่า DATABASE_URL จาก Database เดิม:

1.  ไปที่ [Render Dashboard](https://dashboard.render.com)
2.  เลือก **PostgreSQL database** ที่มีอยู่แล้ว (ที่เป็น free plan)
3.  ในหน้า database info ให้ copy **"Internal Database URL"**
    - จะมีรูปแบบประมาณ: `postgres://username:password@host/database_name`

#### 3.3 ตั้งค่าใน Render Service:

1.  ใน Render Blueprint deployment screen หรือหลัง deploy เสร็จ
2.  คลิกที่ service **"store"**
3.  ไปที่ **Environment** tab
4.  ตั้งค่าดังนี้:

| Environment Variable | ค่าที่ต้องใส่                          |
| -------------------- | -------------------------------------- |
| `DATABASE_URL`       | URL จาก database เดิม (ตามขั้นตอน 3.2) |
| `RAILS_MASTER_KEY`   | `97c5e88078a4a09049ab2df74abbc164`     |
| `RAILS_ENV`          | `production` (ตั้งอัตโนมัติ)           |
| `PORT`               | `10000` (ตั้งอัตโนมัติ)                |

5.  คลิก **"Save Changes"**
6.  Service จะ restart อัตโนมัติ

### 4. Deploy

4. เมื่อเสร็จแล้วจะได้ URL สำหรับเข้าใช้งาน เช่น `https://store-xyz.onrender.com`

## Services ที่จะถูกสร้าง

ตามที่กำหนดใน `render.yaml`:

### Web Service

- **Name**: `store`
- **Type**: Web Service
- **Runtime**: Docker
- **Region**: Singapore
- **Plan**: Free

> [!NOTE]
> Database จะไม่ถูกสร้างใหม่ เนื่องจากเราจะใช้ database ที่มีอยู่แล้วในบัญชีของคุณ

## Environment Variables

| Variable           | Description                  | Source                            |
| ------------------ | ---------------------------- | --------------------------------- |
| `DATABASE_URL`     | PostgreSQL connection string | Manual (from existing database)   |
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
