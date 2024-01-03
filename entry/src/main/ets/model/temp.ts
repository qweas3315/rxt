export type IAddress = {
  addressDetail:string
  consignee:string
  id:number
  isDefault:boolean
  ownName:string
  phone:string
}

export type IExpert = {
  belong:string
  phone:string
  position:string
  profession:string
  realName:string
  userName:string
}

export type IFinance = {
  bankId:number
  combinationIdnum1:string
  combinationIdnum2:string
  combinationName1:string
  combinationName2:string
  combinationPhone1:string
  combinationPhone2:string
  createTime:string
  fileInfo:string
  financeId:number
  idNum:string
  money:number
  ownName:string
  phone:string
  rate:number
  realName:string
  repayment:number
  status:number
  updateTime:string
}

export type IIntention = {
  address:string
  amount:number
  application:string
  area:number
  createTime:string
  item:string
  phone:string
  realName:string
  repaymentPeriod:number
  updateTime:string
  userName:string
}

export type IKnowledge = {
  content:string
  createTime:string
  knowledgeId:number
  ownName:string
  picPath:string
  title:string
  updateTime:string
}

export type IMyPurchase = {
  address:string
  createTime:string
  ownName:string
  picture:string
  purchaseId:number
  purchaseStatus:number
  purchaseType:number
  totalPrice:number
  updateTime:string
}

export type IPasswordParam = {
  newPassword:string
  oldPassword:string
}

export type IPurchaseDetail = {
  count:number
  detailId:number
  orderId:number
  purchaseId:number
  sumPrice:number
  uninPrice:number
}

export type  IQuestion = {
  answer:string
  expertName:string
  id:number
  phone:string
  plantName:string
  question:string
  questioner:string
  status:number
  title:string
}

// export type IReserve = {
//   address:string
//   answer:string
//   area:string
//   expertName:string
//   id:number
//   message:string
//   phone:string
//   plantCondition:string
//   plantDetail:string
//   plantName:string
//   questioner:string
//   soilCondition:string
//   status:number
// }

export type ISellPurchase = {
  address:string
  createTime:string
  orderId:number
  ownName:string
  phone:string
  purchaseId:number
  purchaseStatus:number
  purchaseType:number
  sellPurchaseId:number
  sumPrice:number
  uninPricee:number
  updateTime:number
}

export type IShoppingModel = {
  content:string
  count:number
  orderId:number
  ownName:string
  picture:string
  price:string
  shoppingId:number
  title:string
}