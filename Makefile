NAME = MiniRT
LIBFT_DIR = ./libraries/libft
LIBFT = $(LIBFT_DIR)/libft.a
MLX_DIR = ./libraries/minilibx-linux
MLX = $(MLX_DIR)/libmlx.a
WINDOWS_DIR = ./libraries/windows
WINDOWS = $(WINDOWS_DIR)/windows.a
LIBRARY = -L$(MLX_DIR) -lmlx $(LIBFT) $(WINDOWS) -lmlx -lX11 -lXext -lm

VALGRIND = @valgrind --leak-check=full --show-leak-kinds=all \
	--track-origins=yes --quiet --tool=memcheck --keep-debuginfo=yes

LIBC = ar rcs
CC = cc
RM = rm -f

XSIZE ?= 1280
YSIZE ?= 720

FLAGS = -Wall -Wextra -Werror -Iinc -g3 -DXSIZE=$(XSIZE) -DYSIZE=$(YSIZE)

SRCS = main.c

OBJ_DIR = obj
OBJS = $(patsubst %.c,$(OBJ_DIR)/%.o,$(notdir $(SRCS)))

vpath %c

$(OBJ_DIR)/%.o: %.c
	@mkdir -p $(OBJ_DIR)
	@$(CC) $(FLAGS) -c $< -o $@

all :	$(NAME)

$(NAME) : ${OBJS} ${LIBFT} ${MLX} ${WINDOWS}
	@echo "Building MiniRT.."
	@${CC} ${OBJS} $(FLAGS) $(LIBRARY) -o ${NAME}
	@echo "MiniRT is ready !"

valgrind: $(NAME)
	@echo "Running $(NAME) with Valgrind..."
	$(VALGRIND) ./$(NAME)

$(WINDOWS) :
	@echo "Building windows..."
	@make --no-print-directory -C $(WINDOWS_DIR)

$(MLX) :
	@echo "Building mlx..."
	@make --no-print-directory -C $(MLX_DIR)

$(LIBFT) :
	@echo "Building libft..."
	@make --no-print-directory -C $(LIBFT_DIR)

clean:
	@echo "Cleaning..."
	@rm -rf $(OBJ_DIR)
	@make --no-print-directory -C $(LIBFT_DIR) clean
	@make --no-print-directory -C $(MLX_DIR) clean
	@make --no-print-directory -C $(WINDOWS_DIR) clean

fclean: clean
	@echo "Cleaning all..."
	@rm -f $(NAME)
	@make --no-print-directory -C $(LIBFT_DIR) fclean
	@make --no-print-directory -C $(MLX_DIR) clean
	@make --no-print-directory -C $(WINDOWS_DIR) fclean

re:         fclean all

.PHONY : all clean fclean re
