export class DimUser{

  emp_ID:number
  emp_name:string
  gender:string
  dim_date:string
  dim_reason:string
  dep_ID:number
  dep_name:string
  pos_ID:number
  pos_name:string
  date:string//入职日期
  confirm_date:string//转正日期
  process_state:String

  constructor(emp_ID:number, emp_name:string,gender:string, dim_date:string,dim_reason:string,dep_ID:number,dep_name:string,pos_ID:number,pos_name:string,date:string,confirm_date:string,process_state:String) {
    this.emp_ID=emp_ID
    this.emp_name=emp_name
    this.gender=gender
    this.dim_date=dim_date
    this.dim_reason=dim_reason
    this.dep_ID=dep_ID
    this.dep_name=dep_name
    this.pos_ID=pos_ID
    this.pos_name=pos_name
    this.date=date
    this.confirm_date=confirm_date
    this.process_state=process_state
  }


}