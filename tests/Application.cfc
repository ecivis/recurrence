component {

    this.name = "RecurrenceTests";
    this.sessionManagement = false;
    this.setClientCookies = false;

    rootPath = reReplaceNoCase(getDirectoryFromPath(getCurrentTemplatePath()), "tests(\\|/)", "");
    this.mappings = {
        "/recurrence": rootPath
    };

}