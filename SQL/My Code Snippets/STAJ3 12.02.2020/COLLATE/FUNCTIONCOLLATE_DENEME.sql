ALTER FUNCTION [dbo].[Split]

(

-- Add the parameters for the function here

@List nvarchar(2000),

@SplitOn nvarchar(1)

)

RETURNS @RtnValue TABLE

(

Id int identity(1,1),

Value nvarchar(100)

)

AS

BEGIN

While (Charindex(@SplitOn,@List)>0)

Begin

Insert Into @RtnValue (value)

Select

Value = ltrim(rtrim(Substring(@List,1,Charindex(@SplitOn,@List)-1)))

Set @List = Substring(@List,Charindex(@SplitOn,@List)+len(@SplitOn),len(@List))

End

Insert Into @RtnValue (Value)

Select Value = ltrim(rtrim(@List))
COLLATE SQL_Latin1_General_CP1254_CS_AS;

RETURN
END


