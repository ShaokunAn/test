defaults: main
CFLAGS				=
FFLAGS				=
CPPFLAGS			=
FPPFLAGS			=

BIN_DIR=.

include ${PETSC_DIR}/lib/petsc/conf/variables
include ${PETSC_DIR}/lib/petsc/conf/rules

OBJS = \
${BIN_DIR}/main.o\
${BIN_DIR}/ReadCsvData.o\
${BIN_DIR}/ea.o\
${BIN_DIR}/NormalizeData.o\
${BIN_DIR}/ee.o\
${BIN_DIR}/other_fun.o\
${BIN_DIR}/ee_error.o\
${BIN_DIR}/eels.o\
${BIN_DIR}/SolveDir.o\



${BIN_DIR}/%.o : %.c myhead.h petsc_ee_myhead.h
	-${PETSC_COMPILE_SINGLE} $< -o $@
main: ${OBJS} chkopts
	-${CLINKER} -o ${BIN_DIR}/main ${OBJS} ${PETSC_LIB}
	${RM} ${OBJS}

clear:
	-{RM} ${BIN_DIR}/main

run:
	mpirun -np 36 ./main -pc_type lu -pc_factor_mat_solver_type elemental
