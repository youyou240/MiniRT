#include "windows.h"

int	free_windows(t_win *win)
{			
	mlx_destroy_window(win->mlx_ptr, win->win_ptr);
	free(win);
	exit (1);
}
