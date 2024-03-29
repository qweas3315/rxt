export type IFinance = {
  bankId?: number
  combinationIdnum1?: string
  combinationIdnum2?: string
  combinationName1?: string
  combinationName2?: string
  combinationPhone1?: string
  combinationPhone2?: string
  createTime?: string
  fileInfo?: string
  financeId?: number
  idNum?: string
  money?: string
  ownName?: string
  phone?: string
  rate?: number
  realName?: string
  repayment?: string
  status?: number
  updateTime?: string
}

export type IIntention = {
  address?: string
  amount?: string
  application?: string
  area?: string
  createTime?: string
  item?: string
  phone?: string
  realName?: string
  repaymentPeriod?: string
  updateTime?: string
  userName?: string
  avatar?: string
}

export type IBank = {
  bankId?: number;
  bankName?: string;
  introduce?: string;
  bankPhone?: string;
  money?: string;
  rate?: string;
  repayment?: number;
}