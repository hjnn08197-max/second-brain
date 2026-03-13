import NextAuth from 'next-auth'
import CredentialsProvider from 'next-auth/providers/credentials'

// 演示用户 - 正式环境请使用数据库
const users = [
  {
    id: '1',
    name: 'Admin',
    email: 'admin@example.com',
    password: '123456'
  }
]

const handler = NextAuth({
  providers: [
    CredentialsProvider({
      name: '账号密码登录',
      credentials: {
        email: { label: "邮箱", type: "email" },
        password: { label: "密码", type: "password" }
      },
      async authorize(credentials) {
        if (!credentials?.email || !credentials?.password) {
          return null
        }
        
        const user = users.find(u => u.email === credentials.email)
        
        if (user && user.password === credentials.password) {
          return { id: user.id, name: user.name, email: user.email }
        }
        
        return null
      }
    })
  ],
  pages: {
    signIn: '/login',
  },
  session: {
    strategy: 'jwt'
  }
})

export { handler as GET, handler as POST }
