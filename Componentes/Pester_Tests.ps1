describe 'Do-Something '{ 
 
     it "quando 1 é passado como String, retorna 'string era 1'" { 
         Do-Something -String 1 | should be 'string era 1' 
     } 
 
     it "quando qualquer coisa diferente de 1 é passada como String, ele 
         retorna 'string era outra coisa'"{
        Do-Something -String 'something else' | should be 'string era outra coisa' 
     } 
}