
            TreeManager treeManager = (TreeManager)td.TreeManager;
            SubjectNode from = treeManager.get_NodeByPath("Subject\\iCRMR\\Regression") as SubjectNode;
            SubjectUpdateChildNodes(from);
            

        private void SubjectUpdateChildNodes(SubjectNode folder)
        {
            if (folder == null) return;
            string parentPath = folder.Path.Replace("Subject\\iCRMR\\Regression\\", "");
            testFact = folder.TestFactory;
            List testList = testFact.NewList("");
            SetFolder(parentPath);
            foreach (Test currentTest in testList)
            {
                string QCTestName = currentTest.Name;
                SetTest(QCTestName);
                if (currentTest["TS_USER_03"] != parentPath)
                {
                    try
                    {

                        var vcs = (VCS)currentTest.VCS;
                        if (vcs.IsCheckedOut)
                        {
                            string lockedBy = vcs.LockedBy;
                            if (lockedBy != "ririgoye")
                            {
                                log.Report(parentPath + ",\"" + QCTestName + "\",Locked by " + lockedBy);
                                continue;
                            }
                        }
                        else
                        {
                            vcs.CheckOut("-1", "", false, false, false);
                            vcs.Refresh();
                        }
                        log.Report(parentPath + ",\"" + QCTestName + "\"");
                        currentTest["TS_USER_03"] = parentPath;
                        currentTest.Post();
                        vcs.CheckIn("", "Set subject path", true, true);
                        vcs.Refresh();
                    }
                    catch (Exception ex)
                    {
                    }
                }
            }
            for (int i = 1; i <= folder.Count; i++)
            {
                SubjectNode childFrom = folder.Child[i] as SubjectNode;

                string name = childFrom.Name;

                SubjectUpdateChildNodes(childFrom);

            }
        }