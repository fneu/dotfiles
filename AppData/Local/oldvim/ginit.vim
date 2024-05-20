GuiFont MonoLisa\ NFM:h8
GuiRenderLigatures 1

function! IncreaseFontSize()
  let current_font = &guifont
  let font_parts = split(current_font, ":h")
  let size_part = font_parts[1]
  let size = str2nr(size_part) + 1
  let new_font = font_parts[0] . ":h" . size
  let new_font = substitute(new_font, ' ', '\ ', 'g')
  execute "GuiFont " . new_font
endfunction

function! DecreaseFontSize()
  let current_font = &guifont
  let font_parts = split(current_font, ":h")
  let size_part = font_parts[1]
  let size = str2nr(size_part) - 1
  let new_font = font_parts[0] . ":h" . size
  let new_font = substitute(new_font, ' ', '\ ', 'g')
  execute "GuiFont " . new_font
endfunction

nnoremap <C-Up> :call IncreaseFontSize()<CR>
nnoremap <C-Down> :call DecreaseFontSize()<CR>
