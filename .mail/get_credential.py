import sys
import Keyring as kr

print(kr.get_credential(sys.argv[1], sys.argv[2], sys.argv[3]))
