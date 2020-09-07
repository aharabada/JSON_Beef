using System;

namespace JSON_Beef.Attributes
{
	[AttributeUsage(.Field | .Property | .StaticField, .ReflectAttribute, ReflectUser=.All)]
	public struct IgnoreSerializeAttribute: Attribute
	{
	}

	[AttributeUsage(.All, .ReflectAttribute | .AlwaysIncludeTarget)]
	public struct SerializableAttribute: Attribute
	{
		public String FieldName;
	
		public this() => this = default;
	
		public this(String fieldName)
		{
			FieldName = fieldName;
		}

		public void TestAMethod()
		{
			Console.WriteLine("Test A method");
		}
	}
}
