#include <iostream>
#include <sstream>

using namespace std;

// Simple comment
class Customer {
public:
    string name;
    int id;
};

int main()
{
    Customer obj;

    std::cout << "Enter the ID: ";
    obj.id = 102;
    std::cout << obj.id << std::endl;

    std::cout << "Enter the Name: ";
    obj.name = "John Doe";
    std::cout << obj.name << std::endl << std::endl;

    std::cout << "["<< obj.id << "] " << obj.name << std::endl;

    return 45;
}