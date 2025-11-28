# Ruby on Rails - Recipe Management System

## 📋 สรุปโปรเจค

### 1. ระบบแบ่งส่วนการใช้งาน

- **Public (ไม่ต้อง login)**: Landing Page แสดงเมนูอาหารทั้งหมด
- **Protected (ต้อง login)**: ระบบจัดการ CRUD เมนูอาหารและส่วนประกอบ

### 2. User Roles และ Permissions

| Role     | Email               | Password   | สิทธิ์             |
| -------- | ------------------- | ---------- | ------------------ |
| 👑 Admin | `admin@example.com` | `password` | Manage All (CRUD)  |
| 👨‍💼 Staff | `staff@example.com` | `password` | Read, Edit, Update |
| 🚫 Guest | ไม่ได้ login        | -          | Read Only          |

### 3. Image Preview ด้วย Stimulus

- Preview รูปภาพทันทีเมื่อเลือกไฟล์
- รองรับ Drag & Drop
- แสดงชื่อไฟล์และขนาด
- **ลบรูปภาพได้เมื่อ upload ผิด**

---

## � Screenshots

### Image 1 - Landing Page

หน้าแรกที่ไม่ต้อง login สามารถดูเมนูอาหารทั้งหมดได้

![Image 1](/home/gagabox5678/project_rails/store/app/assets/images/1.png)

### Image 2 - Login Page

หน้า Login สำหรับ Admin และ Staff

![Image 2](/home/gagabox5678/project_rails/store/app/assets/images/2.png)

#### Image 2.1 - Admin Login

![Image 2.1](/home/gagabox5678/project_rails/store/app/assets/images/2.1.png)

#### Image 2.2 - Staff Login

![Image 2.2](/home/gagabox5678/project_rails/store/app/assets/images/2.2.png)

#### Image 2.3 - Login Error Handling

![Image 2.3](/home/gagabox5678/project_rails/store/app/assets/images/2.3.png)

#### Image 2.4 - Authentication Success

![Image 2.4](/home/gagabox5678/project_rails/store/app/assets/images/2.4.png)

#### Image 2.5 - User Session

![Image 2.5](/home/gagabox5678/project_rails/store/app/assets/images/2.5.png)

#### Image 2.6 - Sign Out

![Image 2.6](/home/gagabox5678/project_rails/store/app/assets/images/2.6.png)

### Image 3 - Image Preview with Stimulus

การ Preview รูปภาพแบบ Real-time ในหน้า Create/Update โดยใช้ Stimulus Controller

![Image 3](/home/gagabox5678/project_rails/store/app/assets/images/3.png)

#### Image 3.1 - Image Upload & Preview

แสดงตัวอย่างรูปภาพทันทีเมื่อเลือกไฟล์ พร้อมแสดงชื่อและขนาดไฟล์

![Image 3.1](/home/gagabox5678/project_rails/store/app/assets/images/3.1.png)

#### Image 3.2 - Delete & Re-upload

สามารถกดลบรูปภาพเมื่อ upload ผิดพลาด และเลือกไฟล์ใหม่ได้

![Image 3.2](/home/gagabox5678/project_rails/store/app/assets/images/3.2.png)
