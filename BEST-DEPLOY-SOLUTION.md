# 🚀 最佳解决方案：GitHub CLI + 直接部署

## 📋 推荐方案（无需网页验证）

### 方案A：GitHub CLI（推荐）
```bash
# 1. 登录GitHub（跳过网页验证）
gh auth login

# 2. 按提示选择：
#   - GitHub.com
#   - HTTPS
#   - 登录GitHub账号（会打开浏览器，但验证更简单）
#   - 输入GitHub账号密码

# 3. 创建仓库并推送
cd /root/.openclaw/workspace/second-brain

# 添加远程仓库（替换your-username）
gh repo create second-brain --public --source=. --remote=origin --push

# 4. 启用GitHub Pages
gh repo view second-brain --web
```

### 方案B：Vercel直接部署（最快）
```bash
# 1. 安装Vercel CLI
npm i -g vercel

# 2. 登录Vercel（验证通常更容易）
vercel login

# 3. 部署项目
vercel --prod

# 4. 配置环境变量：
#   NEXTAUTH_URL = https://your-app.vercel.app
#   NEXTAUTH_SECRET = ycfMvbaRmBdIp8d2ScdgIDLIrV8/I8BL+JXmoMSKVlI=
```

### 方案C：Netlify部署
```bash
# 1. 安装Netlify CLI
npm i -g netlify-cli

# 2. 登录并部署
netlify login
netlify deploy --prod
```

## 🎯 推荐执行顺序

1. **先尝试方案A**：GitHub CLI（跳过网页验证）
2. **如果失败，用方案B**：Vercel（验证更简单）
3. **方案C**：Netlify（备选）

## 🔧 环境变量配置
无论选择哪个平台，都需要设置：
```
NEXTAUTH_URL = 你的应用域名
NEXTAUTH_SECRET = ycfMvbaRmBdIp8d2ScdgIDLIrV8/I8BL+JXmoMSKVlI=
```

## 📦 登录信息
- 邮箱：admin@example.com
- 密码：123456

想先尝试哪个方案？