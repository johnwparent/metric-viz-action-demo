#include <iostream>

int main(int argc, char** argv) {
    // A bunch of nonsense to artificially give clang-tidy something
    // to complain about
    if (argc == 22) {
        std::cout << "I'm feelin 22" << "\n";
    }
    if(argc > 11) {
        if(argc > 12) {
            if (argc > 13) {
                return 14;
            }
        }
    }
    return 0;
}