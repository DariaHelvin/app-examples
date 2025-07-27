# HEALTH HUB

## Description

Health Hub is an application that aggregates all the most important medical information for the
user, primarily:

- Scheduled doctor appointments
- Medication schedule

The goal is to plan and store all information in one place. It's a simple, convenient, and
functional application that will be useful for any user, regardless of age.

## Features

- Minimalistic and intuitive design
- Easy to use for people of all ages

## Key Functions

- Section navigation
- Viewing upcoming doctor visits in the calendar
- Adding and removing medications (by clicking)
- Saving entered medications locally on the device
- Filling the calendar with doctor visits (under development) 
- Saving health status information (under development)
- Editing account settings (under development)

## Technologies and Tools

The following technologies were used for the development of the application:

- Programming language: Kotlin
- IDE: Android Studio

## Project Structure and Technical Implementation

### StartScreen

Initial screen with a button to transition to the main screen.

### HomeScreen

Main screen with application navigation. HomeScreen uses FragmentManager to replace fragments when
selecting corresponding menu items. Navigation is done through BottomNavigationView, which listens
for item clicks and replaces the current fragment with CalendarFragment, MedicineScreen, or other
fragments.

### CalendarFragment

A fragment for displaying a homescreen-calendar that allows users to select dates and see scheduled
appointments.

The list of appointments is displayed using RecyclerView, which is updated when data changes. The
adapter (VisitAdapter) manages the connection between the visit data from the VisitList array and
their representation in the calendar, using AsyncListDiffer for asynchronous data list management.
The ViewHolder (VisitViewHolder) binds visit data to view elements and sets a click listener for
interaction with list items. SharedPrefHelper is used for local storage of the visit list.

### MedicineFragment

In this fragment, users can add and remove medications.

The adapter (MedicineAdapter) manages the connection between medication data and their
representation. It uses AsyncListDiffer for asynchronous data list management. The updateDataset
method in the adapter updates the data list and triggers the RecyclerView to redraw. The
ViewHolder (MedicineViewHolder) binds medication data to view elements and sets a click listener to
delete medication.

In the fragment (MedicineScreen), SharedPrefHelper is initialized for local storage of the
medication list. In the onResume method, the adapter is created and set up, data is updated from
SharedPrefHelper. The add medication button saves the new item to the list, updates
SharedPrefHelper, and RecyclerView. The removeMedicine method deletes the selected medication,
updates SharedPrefHelper, and RecyclerView.

### FullcalendarFragment and HealthFragment

Currently inactive, under development:
- FullCalendarFragment is planned for detailed calendar entry
input and their editing 
- HealthFragment is planned for saving user health status information

### Shared Preferences

SharedPreferences are used to store medication data. This allows the medication list to be saved
between application sessions. When a new medication is added, it is saved in SharedPreferences, and
when deleted, the list in SharedPreferences is also updated.

## Challenges

- Aligning and organizing layouts, adapting multi-layer design from mockups
- Working with RecyclerView and its components