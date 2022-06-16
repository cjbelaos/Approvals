using System.Web.UI;

/// <summary>
/// Summary description for MessageBox
/// </summary>
public static class MessageBox
{
    public static void Message(this Page page, string message)
    {
        ScriptManager.RegisterClientScriptBlock(page, page.GetType(), "alertMessage", $"alert('{message}')", true);
    }
}