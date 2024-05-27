import 'package:bloc/bloc.dart';

import '../../../data/api_services.dart';
import '../../../localDatabase/user_profile_db.dart';
import '../../../model/user_model.dart';


part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<GetUserProfile>((event, emit) async {
      emit(GetUserProfileLoading());
      List<UserModel> users = await ApiServices.fetchUserProfiles(id: event.id);
      /// insert into local databse
      if(users.isEmpty)
      {
        emit(GetUserProfileFailed());
      }else{
        for(UserModel user in users)
        {
          await UserProfileDatabaseHelper().insertUser(user);
        }
        emit(GetUserProfileSuccess(users: users));
      }
    });
  }
}
