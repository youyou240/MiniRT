#ifndef WINDOWS_H
# define WINDOWS_H

# include <stdlib.h>
# include "events.h"
# include "../minilibx-linux/mlx.h"
# include "../minilibx-linux/mlx_int.h"

#ifndef XSIZE
# define XSIZE

# endif

#ifndef YSIZE
# define YSIZE 720

# endif

typedef struct s_colors
{
	unsigned int	red;
	unsigned int	blue;
	unsigned int	green;
	unsigned int	transparency;
	unsigned int	colors;
}	t_colors;

typedef struct s_overlay
{
	unsigned int	color;
	int		x_start;
	int		y_start;
	int		x_end;
	int		y_end;
}	t_overlay;

typedef struct s_win
{
	void	*mlx_ptr;
	void	*win_ptr;
	t_img	*img;
}	t_win;

t_win	*create_window(char *name, int x, int y);
int	free_windows(t_win *win);
void	create_fade(t_img *img, unsigned int top_color, unsigned int bottom_color);
void	create_overlay(t_overlay o, t_img *img);

// ----------- colors

unsigned int	gen_trgb(unsigned int opacity, unsigned int red,
			unsigned int green, unsigned int blue);
unsigned int	get_opacity(unsigned int trgb);
unsigned int	get_r(unsigned int trgb);
unsigned int	get_g(unsigned int trgb);
unsigned int	get_b(unsigned int trgb);

// ----------- debug/help

int	print_input_key(int key_pressed);

# endif
