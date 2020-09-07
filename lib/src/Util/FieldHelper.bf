using System;
using System.Reflection;
using JSON_Beef.Attributes;

namespace JSON_Beef.Util
{
	public static class FieldHelper
	{
		public static bool HasFlag(FieldInfo field, FieldFlags flagIn)
		{
			let flags = (int)field.[Friend]mFieldData.mFlags;
			let flag = (int)flagIn;

			return (flags & flag) != 0;
		}

		/**
		 * Retrieves the field name and saves it in the specified string buffer.
		 * @param field The Field.
		 * @param strBuffer The string that will contain the fields name.
		 * @returns .Err when strBuffer was null; .Ok otherwise.
		 * @remarks When the field has a SerializableAttribute the attributes FieldName will be used.
		 */
		public static Result<void> GetFieldName(FieldInfo field, String strBuffer)
		{
			if(strBuffer == null)
				return .Err;
			
			strBuffer.Clear();

			// If the field has the SerializableAttribute we take the fieldName from there
			if(field.GetCustomAttribute<SerializableAttribute>() case .Ok(let attr))
			{
				if(!String.IsNullOrWhiteSpace(attr.FieldName))
				{
					strBuffer.Append(attr.FieldName);
				}
			}

			if(strBuffer.IsEmpty)
				strBuffer.Append(field.Name);

			return .Ok;
		}

		/**
		 * Returns a scoped string containing the field name.
		 * @param field The Field.
		 * @remarks When the field has a SerializableAttribute the attributes FieldName will be used.
		 */
		public static mixin GetScopedFieldName(FieldInfo field)
		{
			String strBuffer = scope:mixin .();
			GetFieldName(field, strBuffer);
			strBuffer
		}
	}
}
