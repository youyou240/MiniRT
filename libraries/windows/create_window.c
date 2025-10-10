#include "windows.h"

t_win	*create_window(char *name, int x, int y)
{
	t_win	*win;

	win = malloc(sizeof(t_win));
	win->mlx_ptr = mlx_init();
	if (!win->mlx_ptr)
	{
		free(win);
		return (NULL);
	}
	win->win_ptr = mlx_new_window(win->mlx_ptr, x, y, name);
	if (!win->win_ptr)
	{
		free(win);
		return (NULL);
	}
	win->img = mlx_new_image(win->mlx_ptr, x, y);
	if (!win->img)
	{
		free(win);
		return (NULL);
	}
	return (win);
}
