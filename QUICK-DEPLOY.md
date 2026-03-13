# 🚀 第二brains项目 - 快速部署指南

## 快速部署步骤

### 1. 复制项目到本地
```bash
# 下载项目
git clone https://github.com/your-username/second-brain.git
cd second-brain
```

### 2. 部署到Vercel
```bash
# 安装Vercel CLI
npm i -g vercel

# 登录（需要浏览器扫码）
vercel login

# 部署
vercel --prod

# 按提示配置环境变量
```

### 3. 设置环境变量
在Vercel设置中添加：
```
NEXTAUTH_URL = https://your-app.vercel.app
NEXTAUTH_SECRET = ycfMvbaRmBdIp8d2ScdgIDLIrV8/I8BL+JXmoMSKVlI=
```

### 4. 登录信息
- **邮箱**: admin@example.com
- **密码**: 123456

## 项目文件结构
```
second-brain/
├── app/
│   ├── page.tsx      # 主页面
│   ├── layout.tsx    # 布局
│   ├── providers.tsx # 认证提供者
│   └── api/auth/    # 认证API
├── package.json
├── tsconfig.json
├── .env.local       # 环境变量
└── README.md
```

## 功能特性
- ✅ 登录保护
- ✅ 全局搜索 (Cmd+K)
- ✅ 多维筛选
- ✅ 简约设计
- ✅ 响应式布局

部署完成后，你的第二大脑系统就上线了！🎉