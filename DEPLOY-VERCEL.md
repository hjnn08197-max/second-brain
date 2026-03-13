# 🚀 Vercel 部署指南

## ✅ 当前状态
- **GitHub仓库**: hjnn08197-max/second-brain
- **最新提交**: cfdbd34
- **Vercel CLI**: 已安装 (v50.32.3)
- **配置文件**: vercel.json 已创建

## 🔐 Vercel 部署方法

### 方法一：通过Vercel Dashboard（推荐）
1. 访问 [Vercel Dashboard](https://vercel.com/dashboard)
2. 点击 "New Project"
3. 选择 "Import Git Repository"
4. 选择 `hjnn08197-max/second-brain` 仓库
5. 点击 "Deploy"

### 方法二：使用Vercel CLI（需要先登录）
```bash
# 1. 登录Vercel（需要浏览器OAuth）
vercel login

# 2. 部署项目
vercel

# 3. 选择项目配置
# 4. 部署完成
```

### 方法三：使用GitHub自动部署
1. 在Vercel Dashboard中导入GitHub仓库
2. Vercel会自动检测Next.js项目
3. 设置环境变量：
   - `NEXTAUTH_URL`: https://your-app.vercel.app
   - `NEXTAUTH_SECRET`: your-secret-key

## 📋 环境变量配置
需要在Vercel中设置以下环境变量：

```env
NEXTAUTH_URL=https://your-app.vercel.app
NEXTAUTH_SECRET=your-secret-key-change-in-production
```

## 🎯 部署后访问
部署完成后，你的应用将在类似 `https://second-brain-git-main-hjnn08197-max.vercel.app` 的地址上可用。

## 🔧 部署选项
- **Framework**: Next.js
- **Output**: Standalone
- **Build Command**: `npm run build`
- **Start Command**: `npm start`
- **Install Command**: `npm install`

---
*部署准备完成: 2026-03-13 10:48:00*