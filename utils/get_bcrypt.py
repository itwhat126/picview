import bcrypt

def get_bcrypt(password, salt=None):

	if salt is None:
		# salt为None的时候是新用户注册的时候
		salt = bcrypt.gensalt(10)
		h_password = bcrypt.hashpw(password, salt)
		# 返回密文
		return h_password, salt
	else:
		try:
			h_password = bcrypt.hashpw(password, salt.encode('utf-8'))
		except Exception as r:
			print(r)
		# 返回密文
		return h_password