using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.SceneManagement;
using SFB;

public class MainSceneManager : MonoBehaviour
{
    public static MainSceneManager instance;
    private void Awake()
    {
        instance = this;
    }
    public void ChoiseLevel(int buildIndex)
    {
        PlayerPrefs.SetInt("replay", 0);
        print(PlayerPrefs.GetInt("replay") + "....................");
        SceneManager.LoadSceneAsync(buildIndex);
    }
    public void RePlayClick()
    {
        OpenScene(StandaloneFileBrowser.OpenFilePanel("Open File", "", "", false));
    }
    void OpenScene(string[] p)
    {
        if (p.Length > 0)
        {
            PlayerPrefs.SetString("replay_path", p[0]);
            string[] scene_name = System.IO.Path.GetFileName(p[0]).Split('-');
            PlayerPrefs.SetInt("replay", 1);
            SceneManager.LoadScene(scene_name[0]);
        }
    }
}
