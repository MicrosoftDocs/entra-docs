---
title: Tutorial - Prepare an Angular single-page app (SPA) for authentication in a customer tenant
description: Learn how to prepare an Angular single-page app (SPA) for authentication with your Microsoft Entra External ID for customers tenant.
services: active-directory
author: garrodonnell
manager: celestedg
ms.service: active-directory
ms.subservice: ciam
ms.topic: tutorial
ms.date: 10/27/2023
ms.author: godonnell
#Customer intent: As a dev, devops, or IT admin, I want to learn how to enable authentication in my own Angular single-page app
---

# Tutorial: Prepare an Angular single-page app (SPA) for authentication in a customer tenant

In the [previous article](./tutorial-single-page-app-angular-sign-in-prepare-tenant.md), you registered an application and configured user flows in your Microsoft Entra External ID for customers tenant. This tutorial demonstrates how to create an Angular single-page app using `npm` and configure the user interface.

In this tutorial;

> [!div class="checklist"]
> * Create an Angular project in Visual Studio Code
> * Configure the user interface for the application

## Prerequisites

* Completion of the prerequisites and steps in [Prepare your customer tenant to authenticate users in an Angular single-page app (SPA)](./tutorial-single-page-app-angular-sign-in-prepare-tenant.md).
* Although any integrated development environment (IDE) that supports Angular applications can be used, this tutorial uses **Visual Studio Code**. You can download it [here](https://visualstudio.microsoft.com/downloads/).
* [Node.js](https://nodejs.org/en/download/).

## Create an Angular project

1. Open Visual Studio Code, select **File** > **Open Folder...**. Navigate to and select the location in which to create your project.
1. Open a new terminal by selecting **Terminal** > **New Terminal**.
1. Run the following commands to create a new Angular project with the name angularspalocal, install Angular Material component libraries, MSAL Browser, MSAL Angular and generate home and profile components.

    ```powershell
    npm install -g @angular/cli
    ng new angularspalocal --routing=true --style=css --strict=false
    cd angularspalocal
    npm install @angular/material @angular/cdk
    npm install @azure/msal-browser @azure/msal-angular
    ng generate component home
    ng generate component profile
    ng generate component guarded
    ```

## Configure the application UI

1. Open _src/styles.css_ to define the CSS. Replace the existing code with the following code snippet.

    ```html
    @import '~@angular/material/prebuilt-themes/deeppurple-amber.css';
    html, body { height: 100%; }
    body { margin: 0; font-family: Roboto, "Helvetica Neue", sans-serif; }
    ```
1. Open _src/app/app.component.html_ and replace the existing code with the following code snippet.
    
    ```HTML
        <mat-toolbar color="primary">
      <a class="title" href="/">{{ title }}</a>
      <div class="toolbar-spacer"></div>
      <a mat-button [routerLink]="['guarded']">Guarded Component</a>
      <button mat-raised-button *ngIf="!loginDisplay" (click)="login()">Login</button>
      <button mat-raised-button color="accent" *ngIf="loginDisplay" (click)="logout()">Logout</button>
    </mat-toolbar>
    <div class="container">
      <!--This is to avoid reload during acquireTokenSilent() because of hidden iframe -->
      <router-outlet *ngIf="!isIframe"></router-outlet>
    </div>
    <footer *ngIf="loginDisplay">
      <mat-toolbar>
        <div class="footer-text"> How did we do? <a
            href="https://forms.office.com/Pages/ResponsePage.aspx?id=v4j5cvGGr0GRqy180BHbR_ivMYEeUKlEq8CxnMPgdNZUNDlUTTk2NVNYQkZSSjdaTk5KT1o4V1VVNS4u"
            target="_blank"> Share your experience with us!</a>
        </div>
      </mat-toolbar>
    </footer>
    ```
1. Open _src/app/app.component.css_ to add CSS styling to the application. Replace any existing code with the following code snippet.
    
    ```css
    .toolbar-spacer {
      flex: 1 1 auto;
    }
    
    a.title {
      color: white;
    }
    
    footer {
      position: fixed;
      left: 0;
      bottom: 0;
      width: 100%;
      color: white;
      text-align: center;
    }
    
    .footer-text {
      font-size: small;
      text-align: center;
      flex: 1 1 auto;
    }
    ```
1. Open _src/app/home/home.component.html_ and replace the existing code with the following code snippet.
    
    ```HTML
    <mat-card class="card-section" *ngIf="!loginDisplay">
      <mat-card-title>Angular single-page application built with MSAL Angular</mat-card-title>
      <mat-card-subtitle>Sign-in with Microsoft Entra External ID for customers</mat-card-subtitle>
      <mat-card-content>This sample demonstrates how to configure MSAL Angular to sign-up, sign-in and sign-out with Microsoft Entra External ID for customers</mat-card-content>
      <button mat-raised-button color="primary" (click)="signUp()">Sign up</button>
    </mat-card>
    <br>
    <p class="text-center" *ngIf="loginDisplay"> See below the claims in your <strong> ID token </strong>. For more
      information, visit: <span>
        <a href="https://docs.microsoft.com/en-us/azure/active-directory/develop/id-tokens#claims-in-an-id-token">
          docs.microsoft.com </a>
      </span>
    </p>
    <div id="table-container">
      <table mat-table [dataSource]="dataSource" class="mat-elevation-z8" *ngIf="loginDisplay">
        <!-- Claim Column -->
        <ng-container matColumnDef="claim">
          <th mat-header-cell *matHeaderCellDef> Claim </th>
          <td mat-cell *matCellDef="let element"> {{element.claim}} </td>
        </ng-container>
        <!-- Value Column -->
        <ng-container matColumnDef="value">
          <th mat-header-cell *matHeaderCellDef> Value </th>
          <td mat-cell *matCellDef="let element"> {{element.value}} </td>
        </ng-container>
        <!-- Value Column -->
        <ng-container matColumnDef="description">
          <th mat-header-cell *matHeaderCellDef> Description </th>
          <td mat-cell *matCellDef="let element"> {{element.description}} </td>
        </ng-container>
        <tr mat-header-row *matHeaderRowDef="displayedColumns sticky: true"></tr>
        <tr mat-row *matRowDef="let row; columns: displayedColumns;"></tr>
      </table>
    </div>
    ```
1. Open _src/app/home/home.component.css_ to add CSS styling to the application. Replace any existing code with the following code snippet.
    
    ```css
    #table-container {
      height: '100vh';
      overflow: auto;
    }
    
    table {
      margin: 3% auto 1% auto;
      width: 70%;
    }
    
    .mat-row {
      height: auto;
    }
    
    .mat-cell {
      padding: 8px 8px 8px 0;
    }
    
    p {
      text-align: center;
    }
    
    .card-section {
      margin: 10%;
      padding: 5%;
    }
    ```


## Next step

> [!div class="nextstepaction"]
> [Configure SPA for authentication](./tutorial-single-page-app-react-sign-in-configure-authentication.md)