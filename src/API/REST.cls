/// Description
Class API.REST Extends %CSP.REST
{

Parameter HandleCorsRequest = 1;

Parameter CONTENTTYPE = "application/json";

XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>
  <Route Url="/test" Method="GET" Call="Test"/>
  <Route Url="/students" Method="GET" Call="getAllStudents"/>
  <Route Url="/student/:id" Method="GET" Call="getStudent"/>
  <Route Url="/addStudent" Method="POST" Call="addStudent"/>
  <Route Url="/deleteSTudent/:id" Method="GET" Call="deleteStudent"/>
  <Route Url="/fetchTests" Method="GET" Call="fetchTests"/>

  <Route Url="/teachers" Method="GET" Call="getAllTeachers"/>
  <Route Url="/writeTest" Method="POST" Call="writeTest"/>

    <Route Url="/doTest" Method="POST" Call="doTest"/>






</Routes>
}

ClassMethod getAllStudents() As %Status
{
  try {
   // set itemsobj = {"students":(##class(School.Student).GetAll())}  
   // write !,sts
    set itemsobj = {}
    set itemsobj."students" = ##class(School.Student).GetAll()

    write itemsobj.%ToJSON()
  }
  catch ex {
    write ex.Log()
    return ex.AsStatus()
  }
  Quit $$$OK
}

ClassMethod getStudent(id As %Integer) As %Status
{
  try {
   // set itemsobj = {"students":(##class(School.Student).GetAll())}  
   // write !,sts
    set itemsobj = {}
    set itemsobj."student" = ##class(School.Student).GetStudent(id)

    write itemsobj.%ToJSON()
  }
  catch ex {
    write ex.Log()
    return ex.AsStatus()
  }
  Quit $$$OK
}

ClassMethod Test() As %Status
{
  Set currentDate = $ZDate($Now(), 3)
  Set obj = {"msg":"It works","toasdday": (currentDate)}
  Write obj.%ToJSON()
  Return $$$OK
}

// ClassMethod addStudent(FirstName As %String = "", LastName As %String = "", Address As %String = "", PHNumber As %Integer = 0, studentTest As School.Test, classStudent As School.Class) As %Status

ClassMethod addStudent() As %Status
{

    set req = {}.%FromJSON(%request.Content) 
   /* set student = ##class(School.Student).%New()
    set student.FirstName = req.FirstName
    set student.LastName = req.LastName
    set student.Address = req.Address
    set student.PHNumber = req.PHNumber*/

   // set st = student.%Save()
  //  do ##class(School.Student).create("t","sda","asd",1452)

  do ##class(School.Student).create(req.FirstName,req.LastName,req.Address,req.PHNumber)
  //do ##class(School.Student).create(FirstName,LastName,Address,PHNumber)


 // set addSt = ##class(School.Student).create(FirstName, LastName, Address, PHNumber, studentTest,classStudent)
  return $$$OK
}

ClassMethod deleteStudent(id As %Integer) As %Status
{
  set delStudent = ##class(School.Student).delete(id)
  Return delStudent
}

ClassMethod fetchTests(id As %Integer) As %Status
{
  try {
   // set itemsobj = {"students":(##class(School.Student).GetAll())}  
   // write !,sts
    set itemsobj = {}
    set itemsobj."tests" = ##class(School.Test).GetAll()
    set itemsobj."classes" = ##class(School.Class).GetAll()


    write itemsobj.%ToJSON()
    }
  catch ex {
    write ex.Log()
    return ex.AsStatus()
  }
  Quit $$$OK
}

ClassMethod getAllTeachers() As %Status
{
  try {
   // set itemsobj = {"students":(##class(School.Student).GetAll())}  
   // write !,sts
    set itemsobj = {}
    set itemsobj."teachers" = ##class(School.Teacher).GetAll()

    write itemsobj.%ToJSON()
  }
  catch ex {
    write ex.Log()
    return ex.AsStatus()
  }
  Quit $$$OK
}

ClassMethod writeTest() As %Status
{

    set req = {}.%FromJSON(%request.Content) 

  do ##class(School.Test).create(req.testName,req.testDetail)

  return $$$OK
}

ClassMethod doTest() As %Status
{



  return $$$OK
}

}
