export class EmployeeMov{
  mov_ID:number
  emp_ID:number
  emp_name:string
  before_dep:number
  before_depname:string
  after_dep:number
  after_depname:string
  before_pos:number
  before_posname:string
  after_pos:number
  after_posname:string
  mov_date:string
  reason:string
  movtype:string
  process_state:string

  constructor( mov_ID:number,emp_ID:number,emp_name:string,before_dep:number,before_depname:string,after_dep:number,after_depname:string,before_pos:number,before_posname:string,after_pos:number,after_posname:string,mov_date:string,reason:string,movtype:string,) {
    this.mov_ID=mov_ID
    this.emp_ID=emp_ID
    this.emp_name=emp_name
    this.before_dep=before_dep
    this.before_depname=before_depname
    this.after_dep=after_dep
    this.after_depname=after_depname
    this.before_pos=before_pos
    this.before_posname=before_posname
    this.after_pos=after_pos
    this.after_posname=after_posname
    this.mov_date=mov_date
    this.reason=reason
    this.movtype=movtype
    this.process_state='未处理'










  }

}













