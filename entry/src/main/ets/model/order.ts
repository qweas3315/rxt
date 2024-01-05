export type ISearchDTO = {
  keyword: string;
  pageNum: number;
}

export type IOrderInfo = {
  address?: string;
  content?: string;
  cooperationName?: string;
  createTime?: string;
  orderId?: number;
  orderStatus?: number;
  ownName?: string;
  picture?: string;
  price?: string;
  title?: string;
  type?: string;
  updateTime?: string;
}

export type IShoppingModel = {
  content: string
  count: number
  orderId: number
  ownName: string
  picture: string
  price: string
  shoppingId: number
  title: string
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