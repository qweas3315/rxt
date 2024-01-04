

export type IFinance = {
  bankId: number
  combinationIdnum1: string
  combinationIdnum2: string
  combinationName1: string
  combinationName2: string
  combinationPhone1: string
  combinationPhone2: string
  createTime: string
  fileInfo: string
  financeId: number
  idNum: string
  money: number
  ownName: string
  phone: string
  rate: number
  realName: string
  repayment: number
  status: number
  updateTime: string
}

export type IIntention = {
  address: string
  amount: number
  application: string
  area: number
  createTime: string
  item: string
  phone: string
  realName: string
  repaymentPeriod: number
  updateTime: string
  userName: string
}

export type IMyPurchase = {
  address: string
  createTime: string
  ownName: string
  picture: string
  purchaseId: number
  purchaseStatus: number
  purchaseType: number
  totalPrice: number
  updateTime: string
}

export type IPasswordParam = {
  newPassword: string
  oldPassword: string
}

export type IPurchaseDetail = {
  count: number
  detailId: number
  orderId: number
  purchaseId: number
  sumPrice: number
  uninPrice: number
}


export type ISellPurchase = {
  address: string
  createTime: string
  orderId: number
  ownName: string
  phone: string
  purchaseId: number
  purchaseStatus: number
  purchaseType: number
  sellPurchaseId: number
  sumPrice: number
  uninPricee: number
  updateTime: number
}
