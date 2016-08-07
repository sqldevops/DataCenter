﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Text;
using Microsoft.Data.Tools.Schema.Sql.UnitTesting;
using Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace DataCenterTest
{
    [TestClass()]
    public class test_EXTR_SERIAL : SqlDatabaseTestClass
    {

        public test_EXTR_SERIAL()
        {
            InitializeComponent();
        }

        [TestInitialize()]
        public void TestInitialize()
        {
            base.InitializeTest();
        }
        [TestCleanup()]
        public void TestCleanup()
        {
            base.CleanupTest();
        }

        [TestCategory("ETL"),TestMethod()]
        public void test_EXTR_SERIAL_after_insert_trigger_new_part()
        {
            SqlDatabaseTestActions testActions = this.test_EXTR_SERIAL_after_insert_trigger_new_partData;
            // Execute the pre-test script
            // 
            System.Diagnostics.Trace.WriteLineIf((testActions.PretestAction != null), "Executing pre-test script...");
            SqlExecutionResult[] pretestResults = TestService.Execute(this.PrivilegedContext, this.PrivilegedContext, testActions.PretestAction);
            // Execute the test script
            // 
            System.Diagnostics.Trace.WriteLineIf((testActions.TestAction != null), "Executing test script...");
            SqlExecutionResult[] testResults = TestService.Execute(this.ExecutionContext, this.PrivilegedContext, testActions.TestAction);
            // Execute the post-test script
            // 
            System.Diagnostics.Trace.WriteLineIf((testActions.PosttestAction != null), "Executing post-test script...");
            SqlExecutionResult[] posttestResults = TestService.Execute(this.PrivilegedContext, this.PrivilegedContext, testActions.PosttestAction);
        }
        [TestCategory("ETL"),TestMethod()]
        public void test_EXTR_SERIAL_insted_of_trigger_new_part()
        {
            SqlDatabaseTestActions testActions = this.test_EXTR_SERIAL_insted_of_trigger_new_partData;
            // Execute the pre-test script
            // 
            System.Diagnostics.Trace.WriteLineIf((testActions.PretestAction != null), "Executing pre-test script...");
            SqlExecutionResult[] pretestResults = TestService.Execute(this.PrivilegedContext, this.PrivilegedContext, testActions.PretestAction);
            try
            {
                // Execute the test script
                // 
                System.Diagnostics.Trace.WriteLineIf((testActions.TestAction != null), "Executing test script...");
                SqlExecutionResult[] testResults = TestService.Execute(this.ExecutionContext, this.PrivilegedContext, testActions.TestAction);
            }
            finally
            {
                // Execute the post-test script
                // 
                System.Diagnostics.Trace.WriteLineIf((testActions.PosttestAction != null), "Executing post-test script...");
                SqlExecutionResult[] posttestResults = TestService.Execute(this.PrivilegedContext, this.PrivilegedContext, testActions.PosttestAction);
            }
        }
        [TestCategory("ETL"),TestMethod()]
        public void test_EXTR_SERIAL_after_insert_trigger_update_part()
        {
            SqlDatabaseTestActions testActions = this.test_EXTR_SERIAL_after_insert_trigger_update_partData;
            // Execute the pre-test script
            // 
            System.Diagnostics.Trace.WriteLineIf((testActions.PretestAction != null), "Executing pre-test script...");
            SqlExecutionResult[] pretestResults = TestService.Execute(this.PrivilegedContext, this.PrivilegedContext, testActions.PretestAction);
            try
            {
                // Execute the test script
                // 
                System.Diagnostics.Trace.WriteLineIf((testActions.TestAction != null), "Executing test script...");
                SqlExecutionResult[] testResults = TestService.Execute(this.ExecutionContext, this.PrivilegedContext, testActions.TestAction);
            }
            finally
            {
                // Execute the post-test script
                // 
                System.Diagnostics.Trace.WriteLineIf((testActions.PosttestAction != null), "Executing post-test script...");
                SqlExecutionResult[] posttestResults = TestService.Execute(this.PrivilegedContext, this.PrivilegedContext, testActions.PosttestAction);
            }
        }
        [TestCategory("ETL"),TestMethod()]
        public void test_EXTR_SERIAL_instead_of_trigger_update_part()
        {
            SqlDatabaseTestActions testActions = this.test_EXTR_SERIAL_instead_of_trigger_update_partData;
            // Execute the pre-test script
            // 
            System.Diagnostics.Trace.WriteLineIf((testActions.PretestAction != null), "Executing pre-test script...");
            SqlExecutionResult[] pretestResults = TestService.Execute(this.PrivilegedContext, this.PrivilegedContext, testActions.PretestAction);
            try
            {
                // Execute the test script
                // 
                System.Diagnostics.Trace.WriteLineIf((testActions.TestAction != null), "Executing test script...");
                SqlExecutionResult[] testResults = TestService.Execute(this.ExecutionContext, this.PrivilegedContext, testActions.TestAction);
            }
            finally
            {
                // Execute the post-test script
                // 
                System.Diagnostics.Trace.WriteLineIf((testActions.PosttestAction != null), "Executing post-test script...");
                SqlExecutionResult[] posttestResults = TestService.Execute(this.PrivilegedContext, this.PrivilegedContext, testActions.PosttestAction);
            }
        }




        #region Designer support code

        /// <summary> 
        /// Required method for Designer support - do not modify 
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction test_EXTR_SERIAL_after_insert_trigger_new_part_TestAction;
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(test_EXTR_SERIAL));
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.NotEmptyResultSetCondition notEmptyResultSetCondition1;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction testInitializeAction;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction test_EXTR_SERIAL_insted_of_trigger_new_part_TestAction;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.NotEmptyResultSetCondition notEmptyResultSetCondition2;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction testCleanupAction;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction test_EXTR_SERIAL_after_insert_trigger_update_part_TestAction;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction test_EXTR_SERIAL_instead_of_trigger_update_part_TestAction;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.RowCountCondition rowCountCondition1;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.RowCountCondition rowCountCondition2;
            this.test_EXTR_SERIAL_after_insert_trigger_new_partData = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestActions();
            this.test_EXTR_SERIAL_insted_of_trigger_new_partData = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestActions();
            this.test_EXTR_SERIAL_after_insert_trigger_update_partData = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestActions();
            this.test_EXTR_SERIAL_instead_of_trigger_update_partData = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestActions();
            test_EXTR_SERIAL_after_insert_trigger_new_part_TestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            notEmptyResultSetCondition1 = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.NotEmptyResultSetCondition();
            testInitializeAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            test_EXTR_SERIAL_insted_of_trigger_new_part_TestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            notEmptyResultSetCondition2 = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.NotEmptyResultSetCondition();
            testCleanupAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            test_EXTR_SERIAL_after_insert_trigger_update_part_TestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            test_EXTR_SERIAL_instead_of_trigger_update_part_TestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            rowCountCondition1 = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.RowCountCondition();
            rowCountCondition2 = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.RowCountCondition();
            // 
            // test_EXTR_SERIAL_after_insert_trigger_new_part_TestAction
            // 
            test_EXTR_SERIAL_after_insert_trigger_new_part_TestAction.Conditions.Add(notEmptyResultSetCondition1);
            resources.ApplyResources(test_EXTR_SERIAL_after_insert_trigger_new_part_TestAction, "test_EXTR_SERIAL_after_insert_trigger_new_part_TestAction");
            // 
            // notEmptyResultSetCondition1
            // 
            notEmptyResultSetCondition1.Enabled = true;
            notEmptyResultSetCondition1.Name = "notEmptyResultSetCondition1";
            notEmptyResultSetCondition1.ResultSet = 1;
            // 
            // test_EXTR_SERIAL_after_insert_trigger_new_partData
            // 
            this.test_EXTR_SERIAL_after_insert_trigger_new_partData.PosttestAction = null;
            this.test_EXTR_SERIAL_after_insert_trigger_new_partData.PretestAction = null;
            this.test_EXTR_SERIAL_after_insert_trigger_new_partData.TestAction = test_EXTR_SERIAL_after_insert_trigger_new_part_TestAction;
            // 
            // testInitializeAction
            // 
            resources.ApplyResources(testInitializeAction, "testInitializeAction");
            // 
            // test_EXTR_SERIAL_insted_of_trigger_new_partData
            // 
            this.test_EXTR_SERIAL_insted_of_trigger_new_partData.PosttestAction = null;
            this.test_EXTR_SERIAL_insted_of_trigger_new_partData.PretestAction = null;
            this.test_EXTR_SERIAL_insted_of_trigger_new_partData.TestAction = test_EXTR_SERIAL_insted_of_trigger_new_part_TestAction;
            // 
            // test_EXTR_SERIAL_insted_of_trigger_new_part_TestAction
            // 
            test_EXTR_SERIAL_insted_of_trigger_new_part_TestAction.Conditions.Add(notEmptyResultSetCondition2);
            resources.ApplyResources(test_EXTR_SERIAL_insted_of_trigger_new_part_TestAction, "test_EXTR_SERIAL_insted_of_trigger_new_part_TestAction");
            // 
            // notEmptyResultSetCondition2
            // 
            notEmptyResultSetCondition2.Enabled = true;
            notEmptyResultSetCondition2.Name = "notEmptyResultSetCondition2";
            notEmptyResultSetCondition2.ResultSet = 1;
            // 
            // testCleanupAction
            // 
            resources.ApplyResources(testCleanupAction, "testCleanupAction");
            // 
            // test_EXTR_SERIAL_after_insert_trigger_update_partData
            // 
            this.test_EXTR_SERIAL_after_insert_trigger_update_partData.PosttestAction = null;
            this.test_EXTR_SERIAL_after_insert_trigger_update_partData.PretestAction = null;
            this.test_EXTR_SERIAL_after_insert_trigger_update_partData.TestAction = test_EXTR_SERIAL_after_insert_trigger_update_part_TestAction;
            // 
            // test_EXTR_SERIAL_after_insert_trigger_update_part_TestAction
            // 
            test_EXTR_SERIAL_after_insert_trigger_update_part_TestAction.Conditions.Add(rowCountCondition1);
            resources.ApplyResources(test_EXTR_SERIAL_after_insert_trigger_update_part_TestAction, "test_EXTR_SERIAL_after_insert_trigger_update_part_TestAction");
            // 
            // test_EXTR_SERIAL_instead_of_trigger_update_partData
            // 
            this.test_EXTR_SERIAL_instead_of_trigger_update_partData.PosttestAction = null;
            this.test_EXTR_SERIAL_instead_of_trigger_update_partData.PretestAction = null;
            this.test_EXTR_SERIAL_instead_of_trigger_update_partData.TestAction = test_EXTR_SERIAL_instead_of_trigger_update_part_TestAction;
            // 
            // test_EXTR_SERIAL_instead_of_trigger_update_part_TestAction
            // 
            test_EXTR_SERIAL_instead_of_trigger_update_part_TestAction.Conditions.Add(rowCountCondition2);
            resources.ApplyResources(test_EXTR_SERIAL_instead_of_trigger_update_part_TestAction, "test_EXTR_SERIAL_instead_of_trigger_update_part_TestAction");
            // 
            // rowCountCondition1
            // 
            rowCountCondition1.Enabled = true;
            rowCountCondition1.Name = "rowCountCondition1";
            rowCountCondition1.ResultSet = 1;
            rowCountCondition1.RowCount = 1;
            // 
            // rowCountCondition2
            // 
            rowCountCondition2.Enabled = true;
            rowCountCondition2.Name = "rowCountCondition2";
            rowCountCondition2.ResultSet = 1;
            rowCountCondition2.RowCount = 1;
            // 
            // test_EXTR_SERIAL
            // 
            this.TestCleanupAction = testCleanupAction;
            this.TestInitializeAction = testInitializeAction;
        }

        #endregion


        #region Additional test attributes
        //
        // You can use the following additional attributes as you write your tests:
        //
        // Use ClassInitialize to run code before running the first test in the class
        // [ClassInitialize()]
        // public static void MyClassInitialize(TestContext testContext) { }
        //
        // Use ClassCleanup to run code after all tests in a class have run
        // [ClassCleanup()]
        // public static void MyClassCleanup() { }
        //
        #endregion

        private SqlDatabaseTestActions test_EXTR_SERIAL_after_insert_trigger_new_partData;
        private SqlDatabaseTestActions test_EXTR_SERIAL_insted_of_trigger_new_partData;
        private SqlDatabaseTestActions test_EXTR_SERIAL_after_insert_trigger_update_partData;
        private SqlDatabaseTestActions test_EXTR_SERIAL_instead_of_trigger_update_partData;
    }
}
