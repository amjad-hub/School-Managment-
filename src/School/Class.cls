Class School.Class Extends (%Persistent, %Library.Populate)
{

/// Description
Property className As %String [ Required ];

Property teacher As School.Teacher [ Required ];

Relationship studentsClass As School.Student [ Cardinality = many, Inverse = classStudent ];

// ClassMethod create(className As %String = "", teacherClass As School.Teacher) As School.Class

ClassMethod create(className As %String = "", teacherID As %String) As School.Class
{
    Set sc = $$$OK
    set class = ..%New()
    set class.className = className 
    do class.teacherSetObjectId(teacherID)

    //, studentTest As School.Test
    set st = class.%Save()
    return class
}

ClassMethod delete(Id As %String = "") As %DynamicArray
{
    set deleteResult = ..%DeleteId(Id)
    set result = {}
    if $$$ISOK(deleteResult) set result = {"result": true}
    else  set result = {"result": false}
    set ErrorMessage = ##class(%SYSTEM.Status).GetErrorText(deleteResult)
    set result.message = ErrorMessage
    return result.%ToJSON()
}

ClassMethod GetAll() As %DynamicArray
{
    set students = []
    set sql = "SELECT * FROM School.Class"

    set data = ##class(%SQL.Statement).%ExecDirect(.stmt, sql)
    while data.%Next() {
      /*  set stud = ##class(School.Student).%OpenId(data.ID)
        set st = stud.%JSONExportToString(.coachJSONstring)
        do cars.%Push({}.%FromJSON(coachJSONstring))*/
         set obj = {
            "className": (data.className)
        }
        do students.%Push(obj)
    }

    return students
}

Storage Default
{
<Data name="ClassDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>className</Value>
</Value>
<Value name="3">
<Value>teacher</Value>
</Value>
</Data>
<DataLocation>^School.ClassD</DataLocation>
<DefaultData>ClassDefaultData</DefaultData>
<IdLocation>^School.ClassD</IdLocation>
<IndexLocation>^School.ClassI</IndexLocation>
<StreamLocation>^School.ClassS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
