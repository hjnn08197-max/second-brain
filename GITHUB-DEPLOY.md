# 🐙 GitHub部署指南

## 步骤1：创建GitHub仓库
```
1. 访问 https://github.com/
2. 点击右上角 "+" → "New repository"
3. 仓库名称：second-brain
4. 描述：你的个人知识管理系统
5. 选择Public（开源）/Private（私有）
6. 不初始化（因为我们已经有代码）
7. 点击 "Create repository"
```

## 步骤2：推送代码
创建仓库后，会显示命令：
```bash
git remote add origin https://github.com/your-username/second-brain.git
git branch -M main
git push -u origin main
```

## 步骤3：部署到GitHub Pages
```
1. 进入仓库页面
2. 点击 "Settings"
3. 找到 "Pages" 部分
4. Source选择 "Deploy from a branch"
5. Branch选择 "main"
6. 文件夹选择 "/" (root)
7. 点击 "Save"
```

## 步骤4：访问应用
通常几分钟后，你的应用可以通过以下URL访问：
https://your-username.github.io/second-brain/

## 注意事项
- GitHub Pages免费但有限制
- 需要自定义域名（可选）
- 自动部署（每次推送都会自动更新）
- 支持HTTPS

## 环境变量设置（可选）
如果需要自定义环境变量，可以在仓库的Settings → Secrets中配置

## 备选方案：GitHub Actions
如果GitHub Pages不满足需求，可以使用GitHub Actions部署到：
- Vercel
- Netlify
- AWS
- 自己的服务器