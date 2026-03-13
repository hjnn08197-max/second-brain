# 部署到Vercel指南

## 快速部署
```bash
# 1. 安装Vercel CLI
npm i -g vercel

# 2. 登录Vercel
vercel login

# 3. 部署项目
cd /root/.openclaw/workspace/second-brain
vercel

# 4. 按照提示配置
# - 选择项目名称
# - 选择框架：Next.js
# - 自动检测环境变量
```

## 环境变量配置
部署时需要设置这些环境变量：
```
NEXTAUTH_URL=https://your-vercel-app.vercel.app
NEXTAUTH_SECRET=your-random-secret-key
```

## 生成随机密钥
```bash
# 生成NextAuth密钥
openssl rand -base64 32
```

## 替代方案：Netlify部署
```bash
# 1. 安装Netlify CLI
npm i -g netlify-cli

# 2. 构建项目
npm run build

# 3. 部署到Netlify
netlify deploy --prod

# 或者使用GitHub Actions自动部署
```

## 推荐方案
1. **推荐**: Vercel部署 - 面向Next.js优化
2. **备选**: Netlify部署 - 通用平台
3. **永久解决**: GitHub + 自动部署

选择哪个？我来帮你执行。