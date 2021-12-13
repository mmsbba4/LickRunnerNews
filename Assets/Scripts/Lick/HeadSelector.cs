using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.Events;
using UnityEngine.SceneManagement;

namespace Lick
{
    public class HeadSelector : MonoBehaviour
    {
        public string player_name;
        public PlayerMove player;
        public UnityEvent StartGame;
        public Image[] selected_mark;
        public GameObject[] head_list;

        private void Start()
        {
            SetHead(PlayerPrefs.GetInt("LastestHead" + player_name));
        }
        public void SetHead(int index)
        {
            PlayerPrefs.SetInt("LastestHead" + player_name, index);
            foreach (var i in selected_mark)
            {
                i.gameObject.SetActive(false);
            }
            selected_mark[index].gameObject.SetActive(true);
            foreach (var i in head_list)
            {
                i.SetActive(false);
            }
            head_list[index].SetActive(true);
            player.SetHead(head_list[index].GetComponentInChildren<SkinnedMeshRenderer>());

        }
        public void Play()
        {
            StartGame.Invoke();
            LickRunner.instance.StartMoving();
        }

        public void BackoHome()
        {
            SceneManager.LoadSceneAsync(0);
        }

    }
}

