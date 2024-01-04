export type ISearchDTO = {
  keyword: string;
  pageNum: number;
}

export type IOrderInfo = {
  address: string;
  content: string;
  cooperationName: string;
  createTime: string;
  orderId: number;
  orderStatus: number;
  ownName: string;
  picture: string;
  price: string;
  title: string;
  type: string;
  updateTime: string;
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