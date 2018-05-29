import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja/ui/app/app_drawer.dart';
import 'package:invoiceninja/redux/app/app_state.dart';
import 'package:invoiceninja/redux/company/company_selectors.dart';
import 'package:invoiceninja/redux/company/company_actions.dart';
import 'package:invoiceninja/data/models/models.dart';

class AppDrawerBuilder extends StatelessWidget {
  AppDrawerBuilder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppDrawerVM>(
      converter: AppDrawerVM.fromStore,
      builder: (context, viewModel) {
        return CustomDrawer(viewModel: viewModel);
      },
    );
  }
}

class AppDrawerVM {
  final List<CompanyEntity> companies;
  final CompanyEntity selectedCompany;
  final String selectedCompanyIndex;
  final Function(String) onCompanyChanged;

  AppDrawerVM({
    @required this.companies,
    @required this.selectedCompany,
    @required this.selectedCompanyIndex,
    @required this.onCompanyChanged,
});

  static AppDrawerVM fromStore(Store<AppState> store) {
    return AppDrawerVM(
      companies: companiesSelector(store.state),
      selectedCompany: store.state.selectedCompany(),
      selectedCompanyIndex: store.state.selectedCompanyIndex.toString(),
      onCompanyChanged: (String companyIndex) {
        store.dispatch(SelectCompany(int.parse(companyIndex)));
      },
    );
  }
}