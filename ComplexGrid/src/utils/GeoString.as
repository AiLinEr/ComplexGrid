package utils
{
	public class GeoString
	{
		public function GeoString()
		{
		}
		
		/**
		 * 字符串的空值标志
		 * */
		public static const MissingValue:String="MissingValue";
		
		public static function isNullOrEmptyOrMissing(value:String):Boolean
		{
			return isNull(value)||isEmpty(value)||isMissing(value);
		}
		
		public static function isNullOrEmpty(value:String):Boolean
		{
			return isNull(value)||isEmpty(value);
		}
		
		public static function isNull(value:String):Boolean
		{
			return value==null;
		}
		
		public static function isEmpty(value:String):Boolean
		{
			return value=="";
		}
		
		public static function isMissing(value:String):Boolean
		{
			return value==GeoString.MissingValue;
		}
		
		public static function isContains(thisStr:String,subStr:String):Boolean
		{
			if(thisStr==null||subStr==null) return false;
			return thisStr.indexOf(subStr,0)>-1;
		}
		
		/**
		 * 连接字符串
		 * beforeAddStr+strArray+afterAddStr+joinString+beforeAddStr+strArray+afterAddStr......
		 * */
		public static function join(strArray:Array,joinString:String,beforeAddStr:String,afterAddStr:String):String
		{
			if(strArray==null||strArray.length==0) return "";
			var tempString:String = "";
			for each(var strItem:String in strArray)
			{
				if(GeoString.isNullOrEmpty(tempString))
					tempString=beforeAddStr+strItem+afterAddStr;
				else
					tempString=tempString+joinString+ beforeAddStr+strItem+afterAddStr;
			}
			return tempString;
		}
		
		/**
		 *在字符串的指定位置插入子串 
		 * @param thisStr 当前字符串 如果当前字符串为任意一种空值，那么返回字符串本身
		 * @param insertPosition 插入位置 如果插入位置小于0，那么在最前面插入子串，如果插入位置大于本身字符串长度，那么在最后面传入子串
		 * @param insertStr 子串
		 * @return 结果字符串
		 * 
		 */
		public static function insert(thisStr:String,insertPosition:int,insertStr:String):String
		{
			if(	isNullOrEmptyOrMissing(thisStr))return thisStr;
			var resultStr:String="";
			if(insertPosition>thisStr.length)
				resultStr = thisStr+insertStr;
			else if(insertPosition<0)
				resultStr = insertStr+thisStr;
			else
			{
				var beforeStr:String=thisStr.substr(0,insertPosition);
				var afterStr:String = thisStr.substr(insertPosition);
				resultStr = beforeStr+insertStr+afterStr;
			}
			return resultStr;
		}
		
		/**
		 *完全替换当前字符串中的子串 
		 * @param thisStr 当前字符串
		 * @param patternStr 搜索字符串
		 * @param replaceStr 替换字符换
		 * @return 结果字符串
		 * 
		 */
		public static function replace(thisStr:String,patternStr:String,replaceStr:String):String
		{
			if(	isNullOrEmptyOrMissing(thisStr))return thisStr;
			var childArray:Array=thisStr.split(patternStr);
			return childArray.join(replaceStr);
		}
		
		/**
		 * 生成随机查询语句：randomstr=randomstr
		 * @param withAnd 是否增加and关联字，默认增加，结果为" and randomstr=randomstr"
		 * */
		public static function GetRandomString(withAnd:Boolean = true):String
		{
			var randomStr:String = Math.random().toString();
			if(withAnd)
				return " and " + randomStr + "=" + randomStr;
			else
				return randomStr + "=" + randomStr;
		}
	}
}