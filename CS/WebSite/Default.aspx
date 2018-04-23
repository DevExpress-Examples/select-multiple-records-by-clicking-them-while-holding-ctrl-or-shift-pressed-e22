<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Grid_Selection_ListBoxTypeSelection_ListBoxTypeSelection" %>
<%@ Register Assembly="DevExpress.Web.ASPxEditors.v8.1" Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dxe" %>
<%@ Register Assembly="DevExpress.Web.ASPxGridView.v8.1" Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dxwgv" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%-- EndRegion --%>


<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Select multiple records by clicking them while holding CTRL or SHIFT pressed</title>
<script type="text/jscript">
var lastSelectedIndex = -1;
function OnRowClick(e) {
    //Clear the text selection
    _aspxClearSelection();
    if(!e.htmlEvent.ctrlKey && !e.htmlEvent.shiftKey) {
        //Unselect all rows
        grid._selectAllRowsOnPage(false);
        //Select the row
        grid.SelectRow(e.visibleIndex, true);
        lastSelectedIndex = e.visibleIndex;
    } else {
        if(e.htmlEvent.ctrlKey) {
            //Select/Unselect the row
            grid.SelectRowCore(e.visibleIndex);
            lastSelectedIndex = e.visibleIndex;
        } else {
            var startIndex = e.visibleIndex > lastSelectedIndex ? lastSelectedIndex + 1 : e.visibleIndex;
            var endIndex = e.visibleIndex > lastSelectedIndex ? e.visibleIndex : lastSelectedIndex - 1;
            for(var i = grid.visibleStartIndex; i < grid.pageRowCount + grid.visibleStartIndex; i ++) {
                if(i == lastSelectedIndex) continue;
                grid.SelectRow(i, i >= startIndex && i <= endIndex);
            }
        }
    }
}
</script>
</head>
<body>
    <form id="form1" runat="server">
    
        <dxwgv:ASPxGridView ID="grid" ClientInstanceName="grid" runat="server" DataSourceID="AccessDataSource1" KeyFieldName="CustomerID">
        <%-- BeginRegion Columns --%>
             <Columns>
                <dxwgv:GridViewDataColumn FieldName="ContactName" VisibleIndex="1">
                </dxwgv:GridViewDataColumn>
                <dxwgv:GridViewDataColumn FieldName="CompanyName" VisibleIndex="2">
                </dxwgv:GridViewDataColumn>
                <dxwgv:GridViewDataColumn FieldName="City" VisibleIndex="3">
                </dxwgv:GridViewDataColumn>
                <dxwgv:GridViewDataColumn FieldName="Region" VisibleIndex="4">
                </dxwgv:GridViewDataColumn>
                <dxwgv:GridViewDataColumn FieldName="Country" VisibleIndex="5">
                </dxwgv:GridViewDataColumn>             
         </Columns>
        <%-- EndRegion --%>
         <ClientSideEvents RowClick="function(s, e) { OnRowClick(e); }" />
    </dxwgv:ASPxGridView>
    <%-- BeginRegion DataSource --%>
     <asp:AccessDataSource ID="AccessDataSource1" runat="server" DataFile="~/App_Data/nwind.mdb"
        SelectCommand="SELECT * FROM [Customers]">
    </asp:AccessDataSource>
    <%-- EndRegion --%>
    </form>
</body>
</html>
