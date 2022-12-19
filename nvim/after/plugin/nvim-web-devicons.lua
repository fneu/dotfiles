local ok, devicons = pcall(require, "nvim-web-devicons")
if not ok then
    return
end

devicons.setup {
    override = {
        cake = {
            icon = "",
            color = "#000000",
            cterm_color = "00",
            name = "Cake"
        },
        csproj = {
            icon = "",
            color = "#000000",
            cterm_color = "00",
            name = "Csproj"
        },
        pyproj = {
            icon = "",
            color = "#000000",
            cterm_color = "00",
            name = "Pyproj"
        },
    };
    color_icons = false;
    default = true;
}
