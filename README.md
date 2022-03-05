# Beginning Saleforce DX Sample App

This is the sample application that accompanies the Beginning Salesforce DX book, authored by Ivan Harris and published by Apress.

## Installing the App Into a Scratch Org

1. Prerequisites:

    - A Salesforce DX development environment (see *Chapter 2 - Environment Setup* in the book)
    - An authorised Dev Hub (see *Chapter 5 - Dev Hub* in the book)

1. Clone the sample app repository:

    ```
    git clone https://github.com/IvanHarris-SalesforceDX-Book/SalesforceDXSampleApp.git
    cd SalesforceDXSampleApp
    ```

1. Create a scratch org:

    ```
    sfdx force:org:create -s -f ./config/project-scratch-def.json -a MySO
    ```

1. Push the app to the scratch org:

    ```
    sfdx force:source:push
    ```

1. Import sample the data:

    ```
    sfdx force:data:tree:import -f ./data/noplan-Account-Case.json
    ```

1. Open the scratch org:

    ```
    sfdx force:org:open
    ```

1. Click on the **App Launcher** and open the **Sales** app.

1. Click on the **Accounts** tab, then the **Sample Account** account (note that you may have to change the list view to **All Accounts** to see the account).

1. Click the **Setup** cog icon and select **Edit Page** from the menu. This opens the *App Builder*.

1. From the **Components** list, drag the **caseInfo** component onto the page.

1. Click the **Save** button and in the *Page Saved* confirmation dialog, click the **Activate** button. This will open the *Activation: Account Record Page Default* dialog, click the **Assign as Org Default** button. Click the **Next** button in the *Assign form factor* dialog that appears. Finally, click the **Save** button in the *Review assignment* dialog.

1. Exit the Lightning *App Builder* by clicking the **arrow** button.

1. The Lightning Web Component is now on the Account regord page and should show that Sample Account has 3 open cases.
