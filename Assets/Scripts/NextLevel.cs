using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class NextLevel : MonoBehaviour
{
    private void Start()
    {
        if (PlayerPrefs.GetInt("replay") == 1)
        {
            Destroy(gameObject);
        }            
     }
    public void NextlevelClick()
    {
        if (SceneManager.GetActiveScene().buildIndex + 1  < SceneManager.sceneCountInBuildSettings)
        {
            SceneManager.LoadSceneAsync(SceneManager.GetActiveScene().buildIndex + 1);
        }
        else
        {
            SceneManager.LoadSceneAsync(0);
        }
    }
}
