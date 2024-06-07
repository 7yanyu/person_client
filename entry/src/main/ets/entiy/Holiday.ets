export class Holiday{
  id:number
  emp_ID:number
  emp_name:string
  annual_holiday:number//年假剩余天数
  lieu_holiday:number//调休假剩余天数
  start_date:string
  end_date:string
  type:string//年假/调休假
  process_state:string//处理状态
  process_date:string//处理时间

}
