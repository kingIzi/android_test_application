function onNavBarListDelegateClicked(index,drawer){
    switch (index){
    case 0:
        _user.getAllVideos()
        _appLoader.state = "HomePage"
        drawer.close()
        break
    case 1:
        _user.getUserFavorites()
        _appLoader.state = "FavoritePage"
        drawer.close()
        break
    case 2:
        _appLoader.state = "ProfilePage"
        drawer.close()
        break
    }
}

function signUpProfile(signUpData){
    const keys = _user.signUpKeys();
    const data = {
        [keys.fullName]: signUpData.fullName,
        [keys.address]: signUpData.address,
        [keys.telephone]: signUpData.telephone,
        [keys.email]: signUpData.email,
        [keys.password]: signUpData.password
    };
    return data;
}
