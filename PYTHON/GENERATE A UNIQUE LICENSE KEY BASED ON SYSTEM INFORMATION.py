
# PYTHON -> GENERATE A UNIQUE LICENSE KEY BASED ON SYSTEM INFORMATION

    from subprocess import check_output
    from requests import session

    def GET_PRODUCT_ID():
        DATA_KEY = check_output('systeminfo').decode("utf-8").split("\n")
        PRODUCT_ID = ''
        for x in DATA_KEY:
            if 'Product ID' in x:
                PRODUCT_ID = (x.split('Product ID:')[1].strip())
                break
        return PRODUCT_ID

    def GET_BIOS_NUMBER():
        DATA_KEY = check_output('wmic diskdrive get SerialNumber').decode().split("\n")[1].strip().strip('\r')
        return DATA_KEY

    def GET_IP_V4():
        return session().get('https://api.ipify.org?format=json').json()['ip']

    def CREATE_KEY_SOFT(key_name):
        main_key = GET_BIOS_NUMBER()
        ip_key = GET_IP_V4()
        if main_key == '':
            backup_key = GET_PRODUCT_ID()+f'_{ip_key}_{key_name}'
            return backup_key
        else:
            return main_key + f'_{key_name}'

    # MAIN SCRIPT
    key_name = "UserName"
    key = CREATE_KEY_SOFT(key_name)
    print(key)
