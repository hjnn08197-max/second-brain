# 🚀 自动化部署系统

## ✅ 系统状态
- **项目**: Second Brain - 第二大脑
- **状态**: 完整的自动化部署系统已配置
- **支持**: Vercel + GitHub Actions
- **脚本**: 自动部署脚本已创建

## 🎯 自动化部署方案

### 方案一：智能脚本部署（推荐）
```bash
cd /root/.openclaw/workspace/second-brain
./auto-deploy-vercel.sh
```

**功能特点**：
- ✅ 自动检查依赖
- ✅ 智能处理Vercel登录
- ✅ 自动拉取最新代码
- ✅ 自动安装依赖
- ✅ 自动部署到Vercel
- ✅ 显示部署结果

### 方案二：GitHub Actions自动部署
```yaml
name: Deploy to Vercel

on:
  push:
    branches: [ main, master ]
  pull_request:
    branches: [ main, master ]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
      - run: npm install
      - run: npm run build
      - uses: vercel/action@v25
```

**功能特点**：
- ✅ 自动触发部署
- ✅ 支持分支推送
- ✅ 支持PR触发
- ✅ 自动构建和部署
- ✅ 集成CI/CD流程

## 📋 部署前准备

### Vercel配置
1. **访问Vercel Dashboard**
   ```
   https://vercel.com/dashboard
   ```

2. **创建项目**
   - 点击 "New Project"
   - 选择 "Import Git Repository"
   - 选择 `hjnn08197-max/second-brain`

3. **配置项目**
   - Framework: Next.js
   - Build Command: `npm run build`
   - Install Command: `npm install`

4. **设置环境变量**
   ```
   NEXTAUTH_URL=https://your-app.vercel.app
   NEXTAUTH_SECRET=your-secret-key-change-in-production
   ```

### GitHub配置
1. **创建GitHub仓库**
   - 已完成: `hjnn08197-max/second-brain`

2. **设置GitHub Secrets**
   ```bash
   # 在GitHub仓库中设置以下Secrets:
   # VERCEL_TOKEN: 你的Vercel API Token
   # VERCEL_ORG_ID: 你的Vercel组织ID
   # VERCEL_PROJECT_ID: 你的Vercel项目ID
   ```

## 🚀 一键部署

### 使用智能脚本
```bash
# 运行智能部署脚本
./auto-deploy-vercel.sh

# 脚本会自动：
# 1. 检查所有依赖
# 2. 处理Vercel登录
# 3. 拉取最新代码
# 4. 安装依赖
# 5. 部署到Vercel
# 6. 显示部署结果
```

### 使用GitHub Actions
```bash
# 推送代码自动触发部署
git add .
git commit -m "Update code"
git push origin main

# GitHub Actions会自动：
# 1. 检出代码
# 2. 安装依赖
# 3. 构建项目
# 4. 部署到Vercel
```

## 📊 部署状态监控

### Vercel Dashboard
- **访问**: https://vercel.com/dashboard
- **功能**: 查看部署状态、日志、性能
- **监控**: 实时构建状态、错误日志

### GitHub Actions
- **访问**: https://github.com/hjnn08197-max/second-brain/actions
- **功能**: 查看CI/CD流程、构建历史
- **监控**: 自动化部署状态

## 🔧 环境变量配置

### 必需变量
```env
NEXTAUTH_URL=https://your-app.vercel.app
NEXTAUTH_SECRET=your-secret-key-change-in-production
```

### 可选变量
```env
NODE_ENV=production
```

## 🎯 预期部署结果

### 访问地址
- **生产环境**: `https://second-brain-git-main-hjnn08197-max.vercel.app`
- **测试环境**: `https://second-brain-git-branchname-hjnn08197-max.vercel.app`

### 登录信息
- **邮箱**: admin@example.com
- **密码**: 123456

### 功能特性
- ✅ 用户认证系统
- ✅ 响应式设计
- ✅ 中文界面
- ✅ 现代化UI
- ✅ 自动HTTPS
- ✅ 全球CDN

## 📱 部署后操作

### 访问网站
```bash
# 打开浏览器访问
open https://second-brain-git-main-hjnn08197-max.vercel.app
```

### 管理部署
```bash
# 查看部署历史
vercel ls

# 重新部署
vercel --prod

# 回滚部署
vercel rollback <deployment-id>
```

## 🚨 故障排除

### 常见问题
1. **部署失败**: 检查依赖和环境变量
2. **访问错误**: 确认域名配置
3. **认证问题**: 重新登录Vercel
4. **构建错误**: 检查代码和依赖

### 解决方案
```bash
# 重新安装依赖
npm install

# 清理构建缓存
rm -rf .next
npm run build

# 重新部署
vercel --prod
```

## 🎉 部署完成

### 成功标志
- ✅ Vercel Dashboard显示部署成功
- ✅ 网站可正常访问
- ✅ 登录功能正常
- ✅ 响应式设计正常

### 下一步
1. 访问部署的网站
2. 测试所有功能
3. 配置自定义域名（可选）
4. 设置监控和日志

---
*自动化部署系统版本: 1.0 | 最后更新: 2026-03-13 14:25:00*

## 🚀 立即开始
```bash
# 运行智能部署脚本
./auto-deploy-vercel.sh

# 或使用GitHub Actions
git push origin main
```