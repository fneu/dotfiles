robocopy ./home $home /s /xx
if (Test-Path $home/AppData/Local/nvim){
	rm -r $home/AppData/Local/nvim
}
robocopy ./nvim $home/AppData/Local/nvim /s /xx
