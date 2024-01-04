export type IQuestion = {
  answer?: string
  expertName: string
  id?: number
  phone: string
  plantName: string
  question: string
  questioner?: string
  status: number
  title: string
}

export type IExpert = {
  belong: string
  phone: string
  position: string
  profession: string
  realName: string
  userName: string
}