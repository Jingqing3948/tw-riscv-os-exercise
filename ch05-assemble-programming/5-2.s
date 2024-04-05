	.text			# Define beginning of text section
	.global	_start		# Define entry _start

_start:
	li x2, 1		# x2 = 1
	li x3, 2		# x3 = 2
    li x5, 3		# x5 = 3
	add x1, x2, x3		# x1 = x2 + x3
    sub x4, x1, x5      # x4 = x1 - x5

stop:
	j stop			# Infinite loop to stop execution
	.end			# End of file
    