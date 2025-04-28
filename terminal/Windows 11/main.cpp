#include <iostream>

int check_command(char* argv) {
	if (argv == "") {
		return 0;
	}
	else if (argv == "-disable_info") {
		return 1;
	}
	else if (argv == "-run_as_admin") {
		return 2;
	}
	return -1;
}

int terminal(char* argv[]) {
	for (int i = 0;i < 3;i++) {
		check_command(argv[i]);
	}
	std::cout << "Type in a command: $/"
	std::cin >> input;
}

int main(int argc, char* argv[]) {
	if(terminal(argv[1]) != 0) {
		return -1;
	}
	return 0;
}