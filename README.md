# tmux-synthweave-theme

Synthwave '84-inspired theme.

Tmux theme paired for my [synthweave](https://github.com/samharju/synthweave.nvim)-theme for neovim, because I happen to really like the colors.

![tmux](https://github.com/samharju/tmux-synthweave-theme/assets/35364923/a25a9ff8-6aca-40cd-8dca-8b69bb368a78)

# Install

Install with [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm):

```
set -g @plugin 'samharju/tmux-synthweave-theme'
```

Fiddle with settings before calling tpm, these are defaults:

```
set -g @synthweave_widgets ''
set -g @synthweave_copy_text 'COPY'
set -g @synthweave_time_format '%T'
set -g @synthweave_date_format '%d-%m-%Y'
set -g @synthweave_prefix_text <prefix>  # default is to show prefix, C-b etc
set -g @synthweave_status_left ' #S'
set -g @synthweave_status_right '@#h '
set -g @synthweave_window_status '#I #{sep} #W'
set -g @synthweave_window_status_current '#I #{sep} #W'
```

Above screenshot uses tmux-cpu widget:

```
set -g @synthweave_widgets 'C #{cpu_fg_color}#{cpu_percentage}#[default] M #{ram_fg_color}#{ram_percentage}#[default] #{sep}'

set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'samharju/tmux-synthweave-theme'
set -g @plugin 'tmux-plugins/tmux-cpu'
run '~/.tmux/plugins/tpm/tpm'
```
