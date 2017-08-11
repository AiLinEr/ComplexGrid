package ale.complexGrid
{
	import ale.complexGrid.renderer.AdvancedGridColumnRenderer;
	import ale.complexGrid.renderer.AdvancedGridHeaderRenderer;
	import ale.complexGrid.renderer.GridColumnItemRenderer;
	import ale.complexGrid.skin.DataGridSkin;
	
	import mx.collections.ArrayCollection;
	import mx.collections.IList;
	import mx.collections.XMLListCollection;
	import mx.core.ClassFactory;
	
	import spark.components.DataGrid;
	import spark.components.gridClasses.GridColumn;

	public class ComplexGridTool
	{
		public function ComplexGridTool()
		{
		}
		
		public static function createGrid(configXML:XML, dataProvider:IList = null):DataGrid
		{
			var tableName:String = configXML.@tableName;
			// 
			var dg:DataGrid = new DataGrid();
			dg.setStyle("skinClass", ale.complexGrid.skin.DataGridSkin);
			dg.columns = configTableColumn(configXML);
			if (dataProvider) dg.dataProvider = dataProvider;
			if (tableName) dg.name = tableName; 
			return dg;
		}
		
		/**
		 * 解析 table ,创建GridColumn 
		 */
		private static function configTableColumn(tableXml:XML):IList
		{
			var columns:IList = new ArrayCollection();
			// 根据configXML.table配置dataGrid.columns 
			columns = setColumns(tableXml);
			return columns;
		}
		
		/**
		 * 重写此方法，控制复杂表头的表格的初始化
		 */
		protected static function setColumns(tableXml:XML):IList
		{
			var results:IList = new ArrayCollection();
			for each(var _column:XML in tableXml.children())
			{
				var gridCol:GridColumn = new GridColumn();
				//	gridCol.sortable = false;
				if (_column.name().localName == "column")
				{
					gridCol.headerText = _column.@headerText.toXMLString();
					gridCol.dataField = _column.@dataField.toXMLString();
					if (results.length > 0)//首列需要类型分级 首列左对齐 
						gridCol.itemRenderer = new ClassFactory(GridColumnItemRenderer);//居中
				}
				else if (_column.name().localName == "columngroup")
				{
					gridCol.headerText = _column.@headerText.toXMLString();
					gridCol.dataField = _column.toXMLString();
					gridCol.headerRenderer = new ClassFactory(AdvancedGridHeaderRenderer);
					if (results.length > 0)//首列需要类型分级 首列左对齐 
						gridCol.itemRenderer = new ClassFactory(AdvancedGridColumnRenderer);//单元格分裂，并居中 
				}
				if (_column.hasOwnProperty("@width"))
					gridCol.width = Number(_column.@width);
				results.addItem( gridCol );
			}
			return results;
		}
	}
}